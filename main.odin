package main

import "core:fmt"
import "core:math"

main :: proc() {
	example :: proc(args: [2]f64) -> [2]f64 {
		x, y := args[0], args[1]
		return {
			//
			x * x - 2 * x - y + 0.5,
			x * x + 4 * y * y - 4,
		}
	}

	variant_5 :: proc(args: [2]f64) -> [2]f64 {
		x, y := args[0], args[1]
		return {
			//
			math.sin(x) + math.sqrt(2 * y * y * y) - 4,
			math.tan(x) - y * y + 4,
		}
	}

	variant_7 :: proc(args: [2]f64) -> [2]f64 {
		x, y := args[0], args[1]
		return {
			//
			4 * x + 11 * y * y,
			11 * x + 7 * y * y * y + 33,
		}
	}

	solve :: proc(system: proc(args: [2]f64) -> [2]f64, initial: [2]f64) {
		ITERATIONS :: 100

		if p, ok := newton_system(system, initial, max_iterations = ITERATIONS); ok {
			fmt.printfln("Found point at %v", p)
		} else {
			fmt.printfln("Unable to find in %d iterations", ITERATIONS)
		}
	}

	solve(example, initial = {1.8, 0.3})
	solve(variant_5, initial = {2.4, 1.8})
	solve(variant_7, initial = {-2.4, -0.9})
}
