using Tilings
using Luxor

@draw begin
	tile = PolyTile([10*n*Point(real(exp(im*2*pi*x/n)), imag(exp(im*2*pi*x/n))) for x in 0:(n-1)], fill=false, stroke=false)
	draw(tile)
end
