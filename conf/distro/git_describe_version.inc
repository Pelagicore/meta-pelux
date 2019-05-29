#
#   Copyright (C) 2019 Luxoft Sweden AB
#   SPDX-License-Identifier: MIT
#

# Generates a version string for DISTRO_VERSION by running git describe.
#
# Assumes there is a tag in the format "[v]<major>.<minor>[-e][</|->Yocto release name]". Optional
# leading 'v' is stripped and '/' is replaced with '-'. Having '/' in DISTRO_VERSION is problematic
# (probably due to it being used in file names).

def git_describe_version(repo_dir_path, default):
    import subprocess

    git_args = ['git', '-C', repo_dir_path, 'describe', '--tags', '--dirty']
    ret = subprocess.run(git_args, stdout=subprocess.PIPE, universal_newlines=True)

    if ret.returncode != 0:
        bb.warn('Failed to run "git describe" in ' + repo_dir_path + ', using "' + default + '"')
        return default

    return ret.stdout.strip().lstrip('v').replace('/', '-')
