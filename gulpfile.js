var gulp  = require('gulp')
var gutil = require('gulp-util')
var exec = require('child_process').exec

// Possibly use spinners from here
// https://www.npmjs.com/package/multispinner
// but that requires integration with the py script.

// # TODO gaze.js error
// # By default, the maximum number of files that Mac OS X can open is set to 12,288 and the maximum number of files a given process can open is 10,240
// # sysctl -A | grep kern.maxfiles
// # kern.maxfiles: 12288
// # kern.maxfilesperproc: 10240
// #
// # sysctl -w kern.maxfiles=20480
// #
// # To make permanent:
// # sudo nvim /etc/sysctl.conf
// # kern.maxfiles=20480
// # kern.maxfilesperproc=24576

gulp.task('clear_terminal', function () {
  process.stdout.write('\033c')
})

// Compile Our Dotfiles
gulp.task('bootstrap', function (cb) {
  gulp.start('clear_terminal')
  exec('sh bootstrap/bootstrap.sh', function (err, stdout, stderr) {
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
    '!.git/*',
    '!build/**',
    '!**/*.md',
    '!**/*.txt'
  ]
	gulp.watch(watchedDirs, ['bootstrap'])
  // gulp.watch('./**/*', gulp.parallel('concat', 'uglify'));
  // gulp.watch('js/*.js', ['lint', 'scripts']);
})

gutil.log('Gulp is running!')

// Default Task
gulp.task('default', ['watch'])