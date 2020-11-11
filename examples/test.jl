### A Pluto.jl notebook ###
# v0.12.7

using Markdown
using InteractiveUtils

# ╔═╡ a6f1b546-2383-11eb-3f21-9dc5e48afc99
using Revise

# ╔═╡ 2247a01e-2381-11eb-277c-310a471ef951
begin
	using Tilings
	using Luxor
	using Colors
end

# ╔═╡ 55b888b6-2381-11eb-1e14-19f9b90edf5d
@draw begin
	n = 6
	tile = Tilings.polytile([10*n*Point(real(exp(im*2*pi*x/n)), imag(exp(im*2*pi*x/n))) for x in 0:(n-1)])
	Tilings.draw(tile)
end

# ╔═╡ 606250f2-2385-11eb-1f87-9b4aeba63f73


# ╔═╡ 56b6d738-2382-11eb-1910-5faa6076fe30
@svg begin 
	function ngonstyle(x)
		setline(2.0)
		setcolor("red")
		fillpreserve()
		setcolor("black")
		strokepath()
	end
	# rotate(pi/2)
	background(Colors.RGB(1.0,0.0,0.0))
	scale(1.5)
	Tilings.hexagonaltile(Tilings.ngontile(6,30, ngonstyle), 40,5)
	scale(1/1.5)
	setcolor((1.0,0.5,0.5))
	ngon(0,0,30*6,6,0,:fill)
	setcolor("black")
	Tilings.hexagonaltile(Tilings.ngontile(6,30,ngonstyle), 35,2)
	rotate(pi/2)
	# draw(Tilings.ngontile(6,35*sqrt(3)))
	draw(Tilings.ngontile(6,35*2*sqrt(3)))
	draw(Tilings.ngontile(6,35*1.5*4))
	draw(Tilings.ngontile(6,35*1.5*6))
	draw(Tilings.ngontile(6,35*1.5*8))
	rotate(pi/2)
	draw(Tilings.ngontile(6,30*6))
	# draw(Tilings.ngontile(6,30*12))
end

# ╔═╡ c62acd62-23b2-11eb-3579-0f0eb87ffcdb
30*7/(1.5*35)

# ╔═╡ 5338dda0-238b-11eb-2dd2-6f4bed2df8a0
@draw begin
	local N = 4
	local sidelen = 80
	local height = sidelen*real(exp(im*pi/N))
	local function sstyle(x)
		setcolor((0.4+0.5*rand(),0.1,0.4+0.2*rand()))
		fillpreserve()
		setcolor("black")
		strokepath()
	end
	setline(1.0)
	local stile = Tilings.polytile([
			Point(0.0, 0.0),
			sidelen*Point(real(exp(im*pi/N)), imag(exp(im*pi/N))),
			sidelen*Point(real(exp(-im*pi/N)), imag(exp(-im*pi/N)))], sstyle)
	for i=1:N
		rotate(pi*2/N)
		Tilings.draw(stile)
		@layer begin
			rotate(pi)
			translate(-2*height,0)
			draw(stile)
		end
		@layer begin
			rotate(pi+pi/N)
			translate(-sidelen,0)
			rotate(pi+pi/N)
			draw(stile)
			rotate(-2*pi/N)
			draw(stile)
		end
	end
	
	for i=1:2N
		setline(1)
		rotate(pi*2/N)
		@layer begin
			rotate(pi+pi/N)
			translate(-sidelen,0)
			rotate(pi/N)
			translate(-2height,0)
			draw(stile)
			translate(2height,0)
			rotate(-2*pi/N)
			translate(-2height,0)
			draw(stile)
		end
		@layer begin
			translate(2height,0)
			draw(stile)
		end
		@layer begin
			rotate(pi/N)
			translate(2sidelen,0)
			rotate(pi/N)
			draw(stile)
			rotate(-2pi/N)
			draw(stile)
		end
	end
end

# ╔═╡ 7297798a-23a0-11eb-0bbc-a38faf9ca80e
function spiral(N=17, dent=N*0.59)
	@draw begin
		sidelen = 100
		# dent = N*0.59
		height = sidelen*real(exp(im*pi/N))
		function sstyle(x)
			setcolor((0.3+0.7*rand(),0.0,0.2+0.5*rand()))
			# sethue(randomhue())
			fillpreserve()
			setcolor("black")
			strokepath()
		end
		setline(1.0)
		stile = Tilings.polytile([
				Point(0.0, 0.0),
				sidelen*0.6*Point(real(exp(im*(pi+dent)/N)), imag(exp(im*(pi+dent)/N))),
				sidelen*Point(real(exp(im*pi/N)), imag(exp(im*pi/N))),
				sidelen*Point(real(exp(-im*pi/N)), imag(exp(-im*pi/N))),
				sidelen*0.6*Point(real(exp(-im*(pi-dent)/N)), imag(exp(-im*(pi-dent)/N)))],
			sstyle)
		for i=1:N
			rotate(pi*2/N)
			Tilings.draw(stile)
			@layer begin
				rotate(pi)
				translate(-2*height,0)
				draw(stile)
			end
			@layer begin
				transform([-1 0 0 1 0 0])
				rotate(pi+pi/N)
				translate(sidelen,0)
				rotate(pi/N)
				draw(stile)
				rotate(-2*pi/N)
				draw(stile)
			end
		end

		for i=1:2N
			setline(1)
			rotate(pi*2/N)
			@layer begin
				rotate(pi+pi/N)
				translate(-sidelen,0)
				rotate(pi/N)
				translate(-2height,0)
				draw(stile)
				translate(2height,0)
				rotate(-2*pi/N)
				translate(-2height,0)
				draw(stile)
			end
			@layer begin
				translate(2height,0)
				transform([1 0 0 -1 0 0])
				draw(stile)
			end
			@layer begin
				rotate(pi/N)
				translate(2sidelen,0)
				rotate(pi/N)
				transform([1 0 0 -1 0 0])
				draw(stile)
				rotate(2pi/N)
				draw(stile)
			end
		end
	end
end

# ╔═╡ 39940a4c-23a8-11eb-0ccc-1f8274898b47


# ╔═╡ 4f93fd3c-23a0-11eb-187a-31f128f923af
spiral(8)

# ╔═╡ Cell order:
# ╠═a6f1b546-2383-11eb-3f21-9dc5e48afc99
# ╠═2247a01e-2381-11eb-277c-310a471ef951
# ╠═55b888b6-2381-11eb-1e14-19f9b90edf5d
# ╠═606250f2-2385-11eb-1f87-9b4aeba63f73
# ╠═56b6d738-2382-11eb-1910-5faa6076fe30
# ╠═c62acd62-23b2-11eb-3579-0f0eb87ffcdb
# ╠═5338dda0-238b-11eb-2dd2-6f4bed2df8a0
# ╠═7297798a-23a0-11eb-0bbc-a38faf9ca80e
# ╠═39940a4c-23a8-11eb-0ccc-1f8274898b47
# ╠═4f93fd3c-23a0-11eb-187a-31f128f923af
