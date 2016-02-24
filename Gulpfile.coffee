gulp  = require('gulp')
shell = require('gulp-shell')

gulp.task 'firebase', ['build'], shell.task(['node_modules/.bin/firebase deploy'])
