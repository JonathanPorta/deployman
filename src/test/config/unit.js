basePath = '../../../';

files = [
	JASMINE,
	JASMINE_ADAPTER,
	'lib/client/vendors/jquery/jquery.min.js',
	'lib/client/vendors/angular/angular.js',
	'src/test/lib/angular/angular-mocks.js',
	'lib/tests/mocks.js',
	'lib/client/vendors/underscore/underscore-min.js',
	'lib/client/vendors/superscore/lib/superscore.min.js',
	'lib/client/vendors/jefri/lib/jefri.min.js',
	'lib/client/vendors/jefri-stores/lib/jefri-stores.min.js',
	'lib/client/scripts/*js',
	'lib/tests/tests.js'
];

autoWatch = false;
singleRun = true;

browsers = ['Chrome'];
