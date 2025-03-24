{
  var files = (from-json < crypt.json)
  set E:TMPAESP = (cat ~/.dryearths.hex)

  peach {|h|
    AES256CTR $h[path] $h[path].enc $h[sample] -ae
    rm $h[path]
  } $files

}
