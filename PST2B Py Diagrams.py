import numpy
import matplotlib.pyplot as plt
from scipy.integrate import solve_ivp

lambda_ = 1.35433
K = 300
h_crit = (lambda_ * K) / 4
initial_u = 200
t_span = (0, 100)
t_eval = numpy.linspace(*t_span, 1000)
h_values = []

def logistic_harvest(t, u, lambda_, K, h):
  return lambda_ * u * (1 - (u / K)) - h

plt.figure(figsize=(10, 6))
for h in h_values:
  sol = solve_ivp(logistic_harvest, t_span, [initial_u], t_eval=t_eval,
args=(lambda_, K, h))
  plt.plot(sol.t, sol.y[0], label=f'h = {h}')

plt.axhline(K / 2, color='gray', linestyle='--', label='K/2 (MSY equilibrium)')
plt.title('Salmon Population Extinction for Harvesting Rate of 101.6')
plt.xticks(numpy.linspace(0, 100, 11), labels=[str(i) for i in range(11)])
plt.xlabel("Time [Years]")
plt.ylabel('Population u(t)')
plt.legend()
plt.grid(True)
plt.tight_layout()
plt.show()

####### NEXT DIAGRAM #######

def compensated_harvesting_rate(t, h_base=None, h_peak=None, t1=None, t2=None):
  if t < t1:
    return h_base
  elif t1 <= t < t2:
    return h_peak
  else:
    return h_base

compensated_h_vectorized = numpy.vectorize(compensated_harvesting_rate)

def extinction_event(t, u, lambda_, K):
  return u[0]

def logistic_with_compensated_h(t, u, lambda_, K):
  h_t = compensated_harvesting_rate(t)
  return lambda_ * u * (1 - u / K) - h_t

sol_comp = solve_ivp(
  logistic_with_compensated_h,
  t_span,
  [initial_u],
  t_eval=t_eval,
  args=(lambda_, K),
  events=extinction_event)

u_comp = numpy.clip(sol_comp.y[0], 0, None)
h_comp = compensated_h_vectorized(sol_comp.t)

extinction_event.terminal = True
extinction_event.direction = -1
plt.figure(figsize=(10, 6))
plt.plot(sol_comp.t, u_comp, label='Population u(t)', color='green')
plt.axhline(initial_u, color='gray', linestyle='--', label='Baseline u = 200')
plt.xticks(numpy.linspace(0, 100, 11), labels=[str(i) for i in range(11)])
plt.xlabel("Time [Years]")
plt.ylabel('Population u(t) [Thousands]')
plt.title('Visualisation of Population Recovery for Peak Harvesting Rate of 105.1')
plt.legend()
plt.grid(True)
plt.tight_layout()
plt.show()
