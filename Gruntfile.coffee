

module.exports = (grunt)->

	pkg = grunt.file.readJSON('package.json')

	sharedModules = Object.keys(pkg["browserify-shim"])

	grunt.initConfig 
				

		watch: 
			dev:
				files: ['**/*.html']
				options:
					livereload: true

			coffee:
				files: ['Gruntfile.coffee', '**/*.coffee']
				tasks: ["browserify:dev"]
				options:
					livereload: true

			compass:
				files: ['**/*.scss']
				tasks: ['compass:dev']
				options:
					livereload: true

			lib:
				files: ['package.json']
				tasks:["browserify"]
				options:
					livereload: true

		connect:
			server:
				options:
					base: './deploy'

		compass:
			dist:
				options:
					sassDir: './app/sass'
					cssDir: './deploy/css'
					environment: 'production'
			dev:
				options:
					sassDir: './app/sass'
					cssDir: './deploy/css'
					environment: 'development'

		browserify:

			lib: 
				files:
					'deploy/js/lib.js': []
				options:
					require: sharedModules

			dev:
				files: 
					'deploy/js/main.js': ['app/main.coffee']
				options:
					transform: ['coffeeify']
					external: sharedModules


	for taskName of pkg.devDependencies when taskName.substring(0,6) is 'grunt-' 
		grunt.loadNpmTasks taskName
	

	grunt.registerTask('dev', ['connect', 'browserify', 'watch'])
	grunt.registerTask('dist', ['browserify', 'compass:dist'])
	grunt.registerTask('lib', ['browserify:lib'])
