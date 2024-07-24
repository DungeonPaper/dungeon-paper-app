const component = (type) => {
  return   {
    templates: ['gen/component'],
    output: `lib/app/widgets/${type}`,
    subdir: false,
  }
}
module.exports = {
  module: {
    templates: ['gen/module'],
    output: 'lib/app/modules',
    subdir: true,
    subdirHelper: 'pascalCase',
  },
  atom: component('atoms'),
  molecule: component('molecules'),
  organism: component('organisms'),
}
