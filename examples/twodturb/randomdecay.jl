using PyPlot, FourierFlows
import FourierFlows.TwoDTurb

 n = 128
 L = 2π
 ν = 8e-5   # Laplacian viscosity
nν = 2
dt = 1e-1   # Time step
nt = 1000   # Number of time steps

prob = TwoDTurb.InitialValueProblem(nx=n, Lx=L, ν=ν, nν=nν, dt=dt)
TwoDTurb.set_q!(prob, rand(n, n))

# Step forward
fig = figure(); tic()
for i = 1:10
  stepforward!(prob, nsteps=nt)
  TwoDTurb.updatevars!(prob)  

  cfl = maximum(prob.vars.U)*prob.grid.dx/prob.ts.dt
  @printf("step: %04d, t: %6.1f, cfl: %.2f, ", prob.step, prob.t, cfl)
  toc(); tic()

  clf(); imshow(prob.vars.q); pause(0.01)
end

show()
