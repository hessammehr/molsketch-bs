
import node_resolve from 'rollup-plugin-node-resolve';

export default {
	dest: 'out/main.js',
	moduleName: 'MolsketchBS',
	entry: 'lib/es6/src/core.js',
	plugins: [ node_resolve() ],
	format: 'iife'
};
