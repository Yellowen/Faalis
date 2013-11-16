module.exports = function (grunt) {
    grunt.initConfig({
        nggettext_extract: {
            pot: {
                files: {
                    'app/assets/templates/locale/templates.pot': ['app/assets/templates/*.html']
                }
            }
        },
        nggettext_compile: {
            all: {
                options: {
                    module: "Dashboard"
                },
                files: {
                    'app/assets/javascripts/red_base/dashboard/locale/translations.js': ['app/assets/templates/locale/*.po']
                }
            }
        }

    });

    grunt.loadNpmTasks('grunt-angular-gettext');
    grunt.registerTask('default', ['nggettext_extract', 'nggettext_compile']);
};
