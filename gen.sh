#!/bin/sh
# Telegram Desktop / rlottie polystar crash sticker generator. See README.md.
cat <<'JSON' | gzip -9cn > crash_sticker.tgs
{"tgs":1,"v":"5.5.2","fr":60,"ip":0,"op":90,"w":512,"h":512,"nm":"poc","ddd":0,"assets":[],"layers":[{"ddd":0,"ind":1,"ty":4,"nm":"polystar_carrier","sr":1,"ks":{"o":{"a":0,"k":100},"r":{"a":0,"k":0},"p":{"a":0,"k":[256,256,0]},"a":{"a":0,"k":[0,0,0]},"s":{"a":0,"k":[100,100,100]}},"ao":0,"shapes":[{"ty":"gr","nm":"g","it":[{"ty":"sr","nm":"Polystar 1","sy":1,"pt":{"a":0,"k":1e38},"p":{"a":0,"k":[0,0]},"r":{"a":0,"k":0},"ir":{"a":0,"k":100},"is":{"a":0,"k":100},"or":{"a":0,"k":200},"os":{"a":0,"k":200}},{"ty":"fl","c":{"a":0,"k":[1,0,0,1]},"o":{"a":0,"k":100},"r":1,"bm":0},{"ty":"tr","p":{"a":0,"k":[0,0]},"a":{"a":0,"k":[0,0]},"s":{"a":0,"k":[100,100]},"r":{"a":0,"k":0},"o":{"a":0,"k":100},"sk":{"a":0,"k":0},"sa":{"a":0,"k":0},"nm":"t"}],"nm":"g","np":3,"bm":0,"hd":false}],"ip":0,"op":90,"st":0,"bm":0}]}
JSON
