# Instance principal

A bit odd requirement where go program which want to be executed using OCI profile from laptop but also dockerlized and executed into OCI k8s. The following code helps testing the program locally and deploy quickly into production.



``` go
package main

import (
    "context"
    "fmt"
    "log"
    "os"
    "os/user"
    "path"
    "errors"

    "github.com/oracle/oci-go-sdk/v65/common"
    "github.com/oracle/oci-go-sdk/v65/common/auth"
    "github.com/oracle/oci-go-sdk/v65/example/helpers"
    "github.com/oracle/oci-go-sdk/v65/identity"
)

const (
	defaultConfigFileName    = "config"
	defaultConfigDirName     = ".oci"
	configFilePathEnvVarName = "OCI_CONFIG_FILE"
)

func ExampleInstancePrincipals() {

    provider := ConfigProvider()

    tenancyID := getOciTenancy()
    request := identity.ListAvailabilityDomainsRequest{
        CompartmentId: &tenancyID,
    }

    client, err := identity.NewIdentityClientWithConfigurationProvider(provider)

    r, err := client.ListAvailabilityDomains(context.Background(), request)
    helpers.FatalIfError(err)

    log.Printf("list of available domains: %v", r.Items)
    fmt.Println("Done")

}

// OCI functions
func ConfigProvider() common.ConfigurationProvider {
    var provider common.ConfigurationProvider
    var err error

    if profile, existed := os.LookupEnv("OCI_CLI_PROFILE"); existed {
        log.Info("Using OCI profile ", profile)
        provider, err = GetOciConfigProvider(profile,"")
    } else {
        log.Info("Using instance principal")
        provider, err = GetOciInstanceProvider()
    }    
    helpers.FatalIfError(err)
    return provider
}

func getOciTenancy() string {
    tenancy, _ := os.LookupEnv("OCI_CLI_TENANCY")
    log.Debug("Tenancy is ",tenancy)
    return tenancy
}

func GetOciConfigProvider(profile string, keyPassword string) (common.ConfigurationProvider, error) {
	configProvider, err := common.ConfigurationProviderFromFileWithProfile(
		getDefaultConfigFilePath(),
		profile,
		keyPassword)

	if err != nil {
		return nil, err
	}

    tenancyID, _ :=  configProvider.TenancyOCID()
    os.Setenv("OCI_CLI_TENANCY", tenancyID)

    region, _ := configProvider.Region()
    os.Setenv("OCI_CLI_REGION", region)


	return configProvider, nil
}

func GetOciInstanceProvider() (common.ConfigurationProvider, error) {
    if _, existed := os.LookupEnv("OCI_CLI_TENANCY"); !existed {
        helpers.FatalIfError(errors.New("undefined OCI_CLI_TENANCY while using Instance Provider"))
    }

    if _, existed := os.LookupEnv("OCI_CLI_REGION"); !existed {
        helpers.FatalIfError(errors.New("undefined OCI_CLI_REGION while using Instance Provider"))
    }

    return auth.InstancePrincipalConfigurationProvider()
}


func getDefaultConfigFilePath() string {
	homeFolder := getHomeFolder()
	defaultConfigFile := path.Join(homeFolder, defaultConfigDirName, defaultConfigFileName)
	if _, err := os.Stat(defaultConfigFile); err == nil {
		return defaultConfigFile
	}
	// Read configuration file path from OCI_CONFIG_FILE env var
	fallbackConfigFile, existed := os.LookupEnv(configFilePathEnvVarName)
	if !existed {
		return defaultConfigFile
	}
	if _, err := os.Stat(fallbackConfigFile); os.IsNotExist(err) {
		return defaultConfigFile
	}
	return fallbackConfigFile
}

func getHomeFolder() string {
	current, e := user.Current()
	if e != nil {
		//Give up and try to return something sensible
		home := os.Getenv("HOME")
		if home == "" {
			home = os.Getenv("USERPROFILE")
		}
		return home
	}
	return current.HomeDir
}

func main() {
	ExampleInstancePrincipals()
}

```

