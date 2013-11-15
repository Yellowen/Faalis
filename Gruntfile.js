module.exports = function(grunt) {

    grunt.initConfig({
        nggettext_extract: {
            pot: {
                files: {
                    'app/assets/templates/locale/templates.pot': ['app/assets/templates/*.html', 'app/assets/templates/*.html.erb']
                }
            }
        }
    });

    grunt.loadNpmTasks('grunt-angular-gettext');

};
