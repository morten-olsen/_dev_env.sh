curl -o $PWD/_dev_env.sh -L https://raw.githubusercontent.com/morten-olsen/_dev_env.sh/master/_dev_env.sh
if [ ! -f $PWD/_dev_env.config.sh ]; then
  curl -o $PWD/_dev_env.config.sh -L https://raw.githubusercontent.com/morten-olsen/_dev_env.sh/master/_dev_env.config.template.sh
fi
curl -o $PWD/_dev_env.md -L https://raw.githubusercontent.com/morten-olsen/_dev_env.sh/master/README.md
chmod +x $PWD/_dev_env.sh
rm -rf .magicenv
echo "Done"