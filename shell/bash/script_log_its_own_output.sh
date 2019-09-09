exec > >(tee -ia ${BASH_SOURCE}.log)
exec 2> >(tee -ia ${BASH_SOURCE}.log >&2)
