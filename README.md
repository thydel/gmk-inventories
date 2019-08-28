# Context

- On `Debian9`
- You are in *group* `staff`

# Deps

```
aptitude install make python jq git hub proot moreutils
```

- `hub` package may be to old
- `jq` package may be to old

## Install recent hub

Only needed to create github repo from a boot file

```
wget https://github.com/github/hub/releases/download/v2.12.3/hub-linux-amd64-2.12.3.tgz
tar zxvf hub-linux-amd64-2.12.3.tgz
proot -w hub-linux-amd64-2.12.3 ./install
```

## Install recent jq

### Compile latest version

To be replaced by a Makefile

```
# Looks like ansible-stable-2.8 don't evaluate become in loops
git clone --branch stable-2.7 --recursive git://github.com/ansible/ansible.git ansible-stable-2.7
source ansible-stable-2.7/hacking/env-setup -q
./install-jq.yml -i localhost,
```

### Get latest compiled version

Easier

```
wget https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64
install -m +x jq-linux64 /usr/local/bin/jq
```

# Install gmk

```
git clone git@github.com:thydel/gmk.git
make -C gmk -f gmk install
```

# Init local repo

```
git init gmk-inventories
```

Then works from gmk-inventories

# Init gmk

```
gmk file=boot init
```

- Create a `boot.js` file from [boot.yml](boot.yml)
- Create a `boot.mk` file from `boot.js`
- Include `boot.mk` to

  - Create a [hub][] config file using token in [pass][]
  - Create `.mailmap`
  - Adds files and dirs to exclude in `.git/info/exclude`

[hub]: https://github.com/github/hub "github.com repo"
[pass]: https://www.passwordstore.org/ "passwordstore.org"


# Create github repo

```
gmk file=boot self/create
```

Will display the cmd to run

# Add files to repos and make first commit

```
git add .
git ci -m 'First commit'
git push --set-upstream origin master
```

# Add and use a gmk file

gmk default do [gmk.yml](gmk.yml) arg file

```
gmk self/config
gmk mailmap
gmk conf
gmk mailmaps
```

# Add and use a Makefile to generate inventory

[Makefile](Makefile) will build inventory files from the mix of public
and private repos of [gmk.yml](gmk.yml)

```
make main
```
