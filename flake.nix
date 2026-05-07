{
	description = "Nix Template";

	outputs = { self }: {
		templates = {
			python-dev = {
				path = ./python-dev;
				description = "Python development environment with OpenMP";
			};
			rust-dev = {
				path = ./rust-dev;
				description = "Rust development environment";
			};
		};

		# Optional: makes `nix flake init -t github:you/templates` work without a name
		defaultTemplate = self.templates.python-dev;
	};
}
