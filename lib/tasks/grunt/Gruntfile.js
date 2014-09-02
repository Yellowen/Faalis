module.exports = function (grunt) {
    grunt.initConfig({
        nggettext_extract: {
            pot: {
                files: {
                    'app/assets/locale/templates.pot': ['app/views/angularjs_templates/**/*.html',
                                                               'app/views/angularjs_templates/**/*.html.erb',
                                                               'app/assets/javascripts/**/*.js',
                                                               'app/assets/javascripts/**/*.js',
                                                               'app/assets/javascripts/**/*.coffee',
                                                               'app/assets/javascripts/**/*.coffee.erb']
                }
            }
        },
        nggettext_compile: {
            all: {
                options: {
                    module: "Dashboard"
                },
                files: {
                    'app/assets/javascripts/faalis/locales/translations.fa.js': ['app/assets/locale/*.fa.pot']
                }
            }
        }

    });

    grunt.loadNpmTasks('grunt-angular-gettext');
    grunt.registerTask('default', ['nggettext_extract', 'nggettext_compile']);
};
