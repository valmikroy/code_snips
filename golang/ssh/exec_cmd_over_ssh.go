package main

import (
	"bytes"
	"fmt"
	"golang.org/x/crypto/ssh"
	"golang.org/x/crypto/ssh/agent"
	"net"
	"os"
)

func main() {
	sshRun("54.193.90.777", "w")
}

func sshRun(addr string, cmd string) error {

	var b bytes.Buffer
	client, err := sshConnect(addr)
	if err != nil {
		return err
	}

	session, err := client.NewSession()
	if err != nil {
		return err
	}

	defer session.Close()

	session.Stdout = &b
	if err := session.Run(cmd); err != nil {
		return err
	}

	fmt.Println(b.String())

	return nil
}

func sshConnect(addr string) (*ssh.Client, error) {

	config := &ssh.ClientConfig{
		User: os.Getenv("USER"),
		Auth: []ssh.AuthMethod{
			sshAgent(),
		},
		HostKeyCallback: ssh.InsecureIgnoreHostKey(),
	}
	conn, err := ssh.Dial("tcp", fmt.Sprintf("%s:22", addr), config)

	if err != nil {
		return nil, fmt.Errorf("Failed to dial: %s", err)
	}
	return conn, nil
}

func sshAgent() ssh.AuthMethod {
	if c, err := net.Dial("unix", os.Getenv("SSH_AUTH_SOCK")); err == nil {
		return ssh.PublicKeysCallback(agent.NewClient(c).Signers)
	}
	return nil
}
