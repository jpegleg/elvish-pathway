set edit:prompt = { styled ' λ ' yellow  }
set edit:rprompt = (constantly ^
     (styled (uidgen)))
fn k {|@k| e:kubectl $@k }
