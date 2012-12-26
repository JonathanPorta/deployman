module.exports = function(grunt) {
	'use strict';
	grunt.initConfig({
		pkg: '<json:package.json>',
		meta: {
			banner: '/* <%= pkg.title || pkg.name %> - v<%= pkg.version %> - ' +
				'<%= grunt.template.today("yyyy-mm-dd") %>\n' +
				'<%= pkg.homepage ? '* ' + pkg.homepage + "\n" : "" %>' +
				'* Copyright (c) <%= grunt.template.today("yyyy") %> <%= pkg.author.name %>;' +
				' Licensed <%= _.pluck(pkg.licenses, "type").join(", ") %> */'
		},
		clean: {
			all: ['lib/'],
			html: ['src/client/*html']
		},
		jade: {
			client: {
				files: {
					'src/client/components.html': ['src/client/components/**/*jade'],
					'src/client/pages.html'     : ['src/client/pages/**/*jade'],
					'lib/client/index.html'      : ['src/client/index.jade']
				}
			}
		},
		stylus: {
			client: {
				files: {
					'lib/client/styles/<%= pkg.name %>.css': ['src/client/**/*styl']
				}
			}
		},
		livescript: {
			server: {
				files: {
					'lib/<%= pkg.name %>.js': ['src/server/**/*ls']
				}
			},
			client: {
				files: {
					'lib/client/scripts/app.js'        : 'src/client/app.ls',
					'lib/client/scripts/filters.js'    : 'src/client/filters/*ls',
					'lib/client/scripts/services.js'   : 'src/client/services/*ls',
					'lib/client/scripts/directives.js' : 'src/client/directives/*ls',
					'lib/client/scripts/components.js' : 'src/client/components/**/*ls',
					'lib/client/scripts/pages.js'      : 'src/client/pages/**/*ls'
				},
				options: {
					bare: false
				}
			},
		},
		copy: {
			vendors: {
				files: {
					'lib/client/vendors/': 'components/**'
				}
			},
            context: {
				files: {
					'lib/client/': 'src/client/*json'
				}
			}
		},
		watch: {
			server: {
				files: [
					'src/server/**/*ls'
				],
				tasks: ['build-server']
			},
			client: {
				files: [
					'src/client/**/*jade',
					'src/client/**/*ls',
					'src/client/**/*styl'
				],
				tasks: ['build-client']
			}
		}
	});

	grunt.loadNpmTasks('grunt-contrib');
	grunt.loadNpmTasks('grunt-livescript');

	grunt.registerTask('build-client', 'jade:client clean:html stylus:client livescript:client copy:vendors copy:context');
	grunt.registerTask('build-server', 'livescript:server');
	grunt.registerTask('build', 'build-server build-client');
	grunt.registerTask('default', 'clean build');
};
