TEMPHOME=tmphome
# Set up choose
mkdir -p $TEMPHOME/choose/src
mkdir -p $TEMPHOME/choose/tools/item1/i1v1
mkdir -p $TEMPHOME/choose/tools/item1/i1v2
mkdir -p $TEMPHOME/choose/tools/item2/i2v1
mkdir -p $TEMPHOME/choose/tools/item2/i2v2
mkdir -p $TEMPHOME/sample_project
mkdir -p $TEMPHOME/.smartcd

oldhome=$HOME
export HOME="$(pwd)/$TEMPHOME"

cp -R $oldhome/.smartcd/lib    $HOME/.smartcd
cp -R $oldhome/.smartcd/helper $HOME/.smartcd

cat <<END > $HOME/.smartcd_config
# Load and configure smartcd
source ~/.smartcd/lib/core/arrays
source ~/.smartcd/lib/core/varstash
source ~/.smartcd/lib/core/smartcd
#smartcd setup cd
#smartcd setup pushd
#smartcd setup popd
#smartcd setup prompt-hook
#smartcd setup exit-hook
#smartcd setup completion
# VARSTASH_AUTOCONFIGURE=1
# VARSTASH_AUTOEDIT=1
# SMARTCD_NO_INODE=1
# SMARTCD_AUTOMIGRATE=1
# SMARTCD_LEGACY=1
# SMARTCD_QUIET=1
# VARSTASH_QUIET=1
END

# Load testing library
source t/tap-functions
source lib/core/choose

plan_tests 14

like "$(choose)"      "Usage" "Called with no options gives usage"
like "$(choose help)" "Usage" "Called with help gives usage"

like "$(choose list)" "Enter either" "choose list asks for more args"
like $(choose list tools | tr '\n' ',') "item1" "Tool list has item1"
like $(choose list tools | tr '\n' ',') "item2" "Tool list has item2"

like $(choose list versions item1 | tr '\n' ',') "i1v1" "Item1 version list has i1v1"
like $(choose list versions item1 | tr '\n' ',') "i1v2" "Item1 version list has i1v2"
like $(choose list versions item2 | tr '\n' ',') "i2v1" "Item1 version list has i1v1"
like $(choose list versions item2 | tr '\n' ',') "i2v2" "Item1 version list has i1v2"


like "$(choose tool)"               "tool"          "choose tool asks for a tool"
like "$(choose tool INVALID)"       "not managed"   "choose tool rejects invalid tool"
like "$(choose tool item1)"         "version"       "choose tool item1 asks for a tool"
like "$(choose tool item1 INVALID)" "not managed"   "choose tool rejects invalid version"
pushd $HOME/sample_project > /dev/null
    choose tool item1 i1v1
    msg="Choose file created in target directory";
    if [[ -e .choose.item1 ]]; then pass "$msg"; else fail "$msg"; fi
popd > /dev/null


# Clean up
rm -rf $HOME
export HOME=$oldhome
