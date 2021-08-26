console.log(process.version);

let x = new Map();

for(let i = 0; i < 999999; i++) {
	x.set(i, { x: i });
}

console.log(process.memoryUsage())
