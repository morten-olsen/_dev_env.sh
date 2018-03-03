echo '
Welcome to magicenv, you are seeing this message bacause you depend on the default `hello`, which most likely mean that you have not defined any dependencies of your own.

To do this, simple open `magicenv.config.sh` in your favorit text editor and replace `install_dep "hello"` with one of your build requirements. To require multible dependencies simply add more `install_dep`s.

Once you have defined all you dependencies it is time to add som functions, using standard bash function style

```
function my_build_script() {
  npm install
  npm run build
}
```

Thats it, you are all set and can now run your functions in your magicenv by running `./magicenv.sh run my_build_script`
' | less