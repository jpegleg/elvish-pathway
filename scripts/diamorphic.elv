var files = (from-json < files.json)

peach {|h|
  var key = (shave 32 (aegis))
  var iv = (shave 24 (aegis))
  var otp = (shave 32 (aegis))
  halberdon $iv $h[data] $key > cipher__$h[name]__$h[uid].e
  echo 'iv: '$iv' encrypted key: '(hexor $otp $key)' otp: '$otp
} $files
