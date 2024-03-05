set edit:prompt = { styled ' λ ' yellow  }

set edit:rprompt = (constantly ^
     (styled (uidgen) blue))

fn k {|@k| e:kubectl $@k }
fn l {|@l| e:ls -larth $@l }
fn f {|@f| e:review $@f }
fn c {|@c| e:chk $@c }
