const file = await Bun.file("./lazy-lock.json")
Object.keys(await file.json()).map(name => `https://github.com/${name}`).forEach(thing => console.log(thing))

