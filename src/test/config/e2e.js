basePath = '../../../';

files = [
	ANGULAR_SCENARIO,
	ANGULAR_SCENARIO_ADAPTER,
	'lib/tests/e2e.js'
];

urlRoot = '/__testacular/';

autoWatch = false;
singleRun = true;

browsers = ['Chrome'];

proxies = {
	'/': 'http://localhost:3000/'
};
