module main

import veb
import rand

pub struct Context {
	veb.Context
}

pub struct App {
mut:
	endpoint map[string]string
	url map[string]string

	base_url string
}

pub fn generate_short() string {
	mut rand_string := ""
	for _ in 0 .. 5 {
		rand_string += rand.element(["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "_", "-"]) or {""}
	}

	return rand_string
}

pub fn (app &App) index(mut ctx Context) veb.Result {
	return ctx.text('Hellowo')
}

@['/new/:url']
pub fn (mut app App) new(mut ctx Context, url string) veb.Result {
	endpoint := generate_short()

	if url in app.url {
		return ctx.text("/" + app.url[url])
	}

	app.endpoint[endpoint] = url
	app.url[url] = endpoint
	println(app.url)
	println(app.endpoint)
	return ctx.text(app.base_url + "/" + endpoint)
}

@['/:short']
pub fn (app &App) short(mut ctx Context, short string) veb.Result {
	if short !in app.endpoint {
		return ctx.not_found()
	}
	endpoint := app.endpoint[short]
	return ctx.redirect("https://" + endpoint)
}

@['/:short'; delete]
pub fn (mut app App) delete_short(mut ctx Context, short string) veb.Result {
	if short !in app.endpoint {
		return ctx.not_found()
	}

	url := app.endpoint[short]
	app.url.delete(url)
	app.endpoint.delete(url)
	return ctx.ok("deleted")
}

fn main() {
	mut app := &App{
		base_url: "localhost:8080"
	}

	veb.run[App, Context](mut app, 8080)
}
