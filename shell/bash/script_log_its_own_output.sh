exec > >(tee -ia foo.log)
exec 2> >(tee -ia foo.log >&2)
