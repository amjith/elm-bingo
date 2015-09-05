'use strict'

var gulp = require('gulp')
var elm = require('gulp-elm')

gulp.task('elm-init', elm.init)

gulp.task('elm', ['elm-init'], function () {
  return gulp.src('Bingo.elm')
    .pipe(elm())
    .pipe(gulp.dest('./'))
})
