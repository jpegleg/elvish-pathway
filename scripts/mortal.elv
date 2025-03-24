{
  var files = (from-json < crypt.json)
  set E:TMPAESP = (cat ~/.dryearths.hex)

  peach {|h|
    AES256CTR $h[path].enc $h[path] $h[sample] -ad
  } $files

}
