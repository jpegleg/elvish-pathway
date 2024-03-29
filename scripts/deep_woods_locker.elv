hexon ~/.goat ~/.goat.hex
ln -sf ~/.starlight ./starlight
var files = (from-json < files.json)
var cheesekey = (chop 32 (cat ~/.goat.hex))

peach {|h|
  var key = (shave 32 (aegis))
  var iv = (shave 24 (aegis))
  var otp = (shave 32 (aegis))
  var cheesecake = (shave 24 (aegis))
  var cryptech = (shielda (hexor $otp $key))
  halberdon $iv $h[data] $key > cipher__$h[name]__$h[uid].e
  makerune cipher__$h[name]__$h[uid].e $h[signer] > cipher__$h[name]__$h[uid]__signature.txt
  chk cipher__$h[name]__$h[uid].e > cipher__$h[name]__$h[uid]__chk.json
  echo $cryptech > cipher__$h[name]__$h[uid]__encrypted__key.ae
  toggle cipher__$h[name]__$h[uid]__encrypted__key.ae
  daggeron $otp > cipher__$h[name]__$h[uid]__otp.che
  halberdon $cheesecake cipher__$h[name]__$h[uid]__otp.che $cheesekey > cipher__$h[name]__$h[uid]__otp.enc
  gold > cipher__$h[name]__$h[uid]__otp.che
  rm cipher__$h[name]__$h[uid]__otp.che
  toggle cipher__$h[name]__$h[uid]__otp.enc
  daggeron $cheesecake > cipher__$h[uid]_cake.txt
  tar czvf w__$h[uid]_(date +%Y%m%d%H%M%S).tgz ./cipher__*$h[uid]*
  unlink starlight
} $files
