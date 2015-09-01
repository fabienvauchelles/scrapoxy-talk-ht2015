# Generated on 2015-02-22 using generator-reveal 0.4.0
module.exports = (grunt) ->

    grunt.initConfig

        watch:

            livereload:
                options:
                    livereload: true
                files: [
                    'index.html'
                    'slides/**/*.{md,html}'
                    'js/*.js'
                    'css/*.css'
                ]

            index:
                files: ['slides/*.json']
                tasks: ['buildIndex']

            coffeelint:
                files: ['Gruntfile.coffee']
                tasks: ['coffeelint']

            jshint:
                files: ['js/*.js']
                tasks: ['jshint']

        sass:

            theme:
                files:
                    'css/theme.css': 'bower_components/reveal-fabien-theme/css/theme.scss'

        connect:

            livereload:
                options:
                    port: 9999
                    # Change hostname to '0.0.0.0' to access
                    # the server from outside.
                    hostname: 'localhost'
                    base: '.'
                    open: true
                    livereload: true

        coffeelint:

            options:
                indentation:
                    value: 4
                max_line_length:
                    level: 'ignore'

            all: ['Gruntfile.coffee']

        jshint:

            options:
                jshintrc: '.jshintrc'

            all: ['js/*.js']

        copy:

            dist:
                files: [{
                    expand: true
                    src: [
                        'slides/**'
                        'bower_components/**'
                        'js/**'
                        'img/**'
                        'css/*.css'
                    ]
                    dest: 'dist/'
                },{
                    expand: true
                    src: ['index.html']
                    dest: 'dist/'
                    filter: 'isFile'
                }]

        buildcontrol:

            options:
                dir: 'dist'
                commit: true
                push: true
                message: 'Built from %sourceCommit% on branch %sourceBranch%'
            pages:
                options:
                    remote: 'git@github.com:fabienvauchelles/scrapoxy-talk-ht2015'
                    branch: 'gh-pages'


    # Load all grunt tasks.
    require('load-grunt-tasks')(grunt)

    grunt.registerTask 'buildIndex',
        'Build index.html from bower_components/reveal-fabien-theme/templates/_index.html and slides/list.json.',
        ->
            indexTemplate = grunt.file.read 'bower_components/reveal-fabien-theme/templates/_index.html'
            sectionTemplate = grunt.file.read 'bower_components/reveal-fabien-theme/templates/_section.html'
            slides = grunt.file.readJSON 'slides/list.json'
            config = grunt.file.readJSON 'slides/config.json'

            html = grunt.template.process indexTemplate, data:
                config:
                    config
                slides:
                    slides
                section: (slide) ->
                    grunt.template.process sectionTemplate, data:
                        slide:
                            slide
            grunt.file.write 'index.html', html

    grunt.registerTask 'test',
        '*Lint* javascript and coffee files.', [
            'coffeelint'
            'jshint'
        ]

    grunt.registerTask 'serve',
        'Run presentation locally and start watch process (living document).', [
            'buildIndex'
            'sass'
            'connect:livereload'
            'watch'
        ]

    grunt.registerTask 'dist',
        'Save presentation files to *dist* directory.', [
            'test'
            'sass'
            'buildIndex'
            'copy'
        ]

    grunt.registerTask 'deploy',
        'Deploy to Github Pages', [
            'dist'
            'buildcontrol'
        ]


    # Define default task.
    grunt.registerTask 'default', [
        'test'
        'serve'
    ]
