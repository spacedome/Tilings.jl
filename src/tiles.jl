abstract type Tile end

struct PolyTile <: Tile
	points
	style
end

polytile(points) = PolyTile(points, x->strokepath())
polytile(points, style) = PolyTile(points, style)

struct NgonTile <: Tile
	n
	radius
	style
end

ngontile(n,r) = NgonTile(n,r, x->strokepath())
ngontile(n,r,style) = NgonTile(n,r, style)


function draw(tile::PolyTile)
	@layer begin
		poly(tile.points, :path, close=true)
		tile.style(0)
	end
end

function fill(tile::PolyTile)
	@layer begin
		poly(tile.points, :fill, close=true)
	end
end

function draw(tile::NgonTile)
	@layer begin
		ngon(0,0,tile.radius,tile.n,0, :path)
		tile.style(0)
	end
end

function hexagonaltile(tile::Tile, radius, range)
	for j in -range:range
		@layer begin
			translate(0, j*sqrt(3)*radius)
			for i in -range:range
				@layer begin
					translate(i*1.5*radius,i*sqrt(3)*0.5*radius)
					if (abs(i+j) <= range) draw(tile) end
					# draw(tile)
				end
			end
		end
	end				
end
