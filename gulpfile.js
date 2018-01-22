var gulp  = require('gulp')
var gutil = require('gulp-util')
var exec = require('child_process').exec

function clearTerminal () {
  console.log('\n'.repeat(1000))
}

gulp.task('clearTerminal', clearTerminal)


// TODO Possibly use spinners from here
// https://www.npmjs.com/package/multispinner
// but that requires integration with the py script.

// Compile Our Dotfiles
gulp.task('bootstrap', function (cb) {
  exec('sh bootstrap/bootstrap.sh', function (err, stdout, stderr) {
    // I think calling it in a gulp task prevents an intermittent error.
    gulp.start('clearTerminal')
    console.log(stdout)
    console.log(stderr)
    cb(err)
  })
})

// Watch Files For Changes
// Template filenames must match end with *.tpl
gulp.task('watch', function () {

  // Run once at start.
  gulp.start('bootstrap')

  const watchedDirs = [
    '**/*.tpl',
    'shell/**',
    '!build/**',
    '!**/*.md',
    '!**/*.txt'
  ]
	gulp.watch(watchedDirs, ['bootstrap'])
  // gulp.watch('./**/*', gulp.parallel('concat', 'uglify'));
  // gulp.watch('js/*.js', ['lint', 'scripts']);
})

// gutil.log('Gulp is running!')

// Default Task
gulp.task('default', ['watch'])