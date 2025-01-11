default: build flash notify

build:
	nix build

flash:
	cp result/glove80.uf2 /run/media/$(USER)/GLV80LHBOOT/CURRENT.UF2

notify: 
	dunstify -u normal -t 5000 "Glove80 flashed successfully"
