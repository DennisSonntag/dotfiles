
fn main() {
	let links = std::fs::read_to_string("../links").unwrap();
	let links = links.trim();

	for link in links.lines() {
	    open::that(link).unwrap();
	}
}
