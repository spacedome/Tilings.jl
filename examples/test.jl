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

# ╔═╡ 4f93fd3c-23a0-11eb-187a-31f128f923af
spiral(8, 8*.59)

# ╔═╡ 3063b7e6-2462-11eb-2285-a978a12c540d
function spiral2()
	@svg begin
		local function sstyle(x)
			setcolor((0.3+0.6*rand(),0.05,0.3+0.4*rand()))
			fillpreserve()
			setline(1)
			setcolor("lavender")
			strokepath()
		end
		setline(0.5)
		θ = pi/12
		slen = 13.0
		# translate(0,150)
		a1 = exp(-θ*im)
		a2 = a1 + exp(0θ*im)
		a3 = a2 + exp(1θ*im)
		a4 = a3 + exp(2θ*im)
		b1 = complex(1.0,0.0)
		b2 = b1 + exp(θ*im)
		b3 = b2 + exp(2θ*im)
		b4 = b3 + exp(3θ*im)
		
		points = [Point(0.0, 0.0),
				  Point(reim(a1)), Point(reim(a2)), Point(reim(a3)), Point(reim(a4)),
				  Point(reim(b4)), Point(reim(b3)), Point(reim(b2)), Point(reim(b1))]
		local stile = Tilings.polytile(points, sstyle)
		scale(slen)
		
		rotate(5θ)
		translate(reim(b4*0.5)...)
		rotate(-5θ)
		
		@layer begin
			rotate(-7θ)
			for i=1:8
				draw(stile)
				rotate(θ)
			end
			draw(stile)
			for j=0:7
				for i=1:12
					for k=1:j
						translate(reim(b3-a4)...)
						draw(stile)
						@layer begin
							translate(reim(a4)...)
							rotate(-2θ)
							transform([1 0 0 -1 0 0])
							translate(reim(-b4)...)
							draw(stile)
						end
					end
					translate(reim(b3-a4)...)
					draw(stile)
					rotate(θ)
					draw(stile)
					@layer begin
						translate(reim(a4)...)
						rotate(-3θ)
						transform([1 0 0 -1 0 0])
						translate(reim(-b3)...)
						draw(stile)
					end
				end
			end
		end
		transform([-1 0 0 1 0 0])
		rotate(5θ)
		translate(reim(-b4)...)
		@layer begin
			for i=1:15
				draw(stile)
				rotate(-θ)
			end
			draw(stile)
			# setline(3)
			for j=0:7
				for i=1:(12 + (j==0))
					for k=1:j
						draw(stile)
						@layer begin
							translate(reim(a4)...)
							rotate(-2θ)
							transform([1 0 0 -1 0 0])
							translate(reim(-b4)...)
							draw(stile)
						end
						translate(reim(-b3+a4)...)
					end
					
					draw(stile)
					rotate(-θ)
					draw(stile)
					@layer begin
						translate(reim(a4)...)
						rotate(-2θ)
						transform([1 0 0 -1 0 0])
						translate(reim(-b4)...)
						draw(stile)
					end
					translate(reim(-b3+a4)...)
				end
			end
		end
	end
end

# ╔═╡ 65841844-2462-11eb-2c40-e908aa584922
spiral2()

# ╔═╡ Cell order:
# ╠═a6f1b546-2383-11eb-3f21-9dc5e48afc99
# ╠═2247a01e-2381-11eb-277c-310a471ef951
# ╠═55b888b6-2381-11eb-1e14-19f9b90edf5d
# ╠═606250f2-2385-11eb-1f87-9b4aeba63f73
# ╠═56b6d738-2382-11eb-1910-5faa6076fe30
# ╠═c62acd62-23b2-11eb-3579-0f0eb87ffcdb
# ╠═5338dda0-238b-11eb-2dd2-6f4bed2df8a0
# ╠═7297798a-23a0-11eb-0bbc-a38faf9ca80e
# ╠═4f93fd3c-23a0-11eb-187a-31f128f923af
# ╠═3063b7e6-2462-11eb-2285-a978a12c540d
# ╠═65841844-2462-11eb-2c40-e908aa584922
