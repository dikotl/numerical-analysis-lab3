package main

import "core:math/linalg"

newton_system :: proc(
	system: proc(args: [$N]$T) -> [N]T,
	guess: [N]T,
	epsilon := 1e-6,
	max_iterations := 100,
) -> (
	vars: [N]T,
	ok: bool,
) #optional_ok {
	for i in 0 ..= max_iterations {
		F := system(vars)

		if linalg.length(F) < epsilon {
			ok = true
			break
		}

		delta := LUP_solve(jacobian(system, vars), -F)

		for i in 0 ..< N {
			vars[i] += delta[i]
		}
	}
	return
}

jacobian :: proc(system: proc(args: [$N]$T) -> [N]T, args: [N]T, d := 1e-6) -> (J: matrix[N, N]T) {
	F := system(args)

	for j in 0 ..< N {
		args_step := args
		args_step[j] += d
		F_step := system(args_step)

		for i in 0 ..< N {
			J[i, j] = (F_step[i] - F[i]) / d
		}
	}
	return
}
