#!/usr/bin/env bash

open https://github.com/lucasbrasilino/ngx_http_simple_example

# Compiling
./configure --add-module=/path/to/ngx_http_simple_module

# Configuring
	location /simple {
		simple_example;
	}

	location /same {
		simple_example;
		simple_example_content "<html><body><h1>Always same content</h1></body></html>"
	}

	location /foo {
		simple_example;
		simple_example_last_modified on;
	}
