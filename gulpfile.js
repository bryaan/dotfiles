var gulp  = require('gulp')
var gutil = require('gulp-util')
var exec = require('child_process').exec;
var clear = require('clear');

// Compile Our Dotfiles
gulp.task('bootstrap', function(cb) {
  // var options = {
  //   continueOnError: false, // default = false, true means don't emit error event
  //   pipeStdout: false, // default = false, true means stdout is written to file.contents
  //   customTemplatingThing: "test" // content passed to lodash.template()
  // };
  var reportOptions = {
  	err: true, // default = true, false means don't write err
  	stderr: true, // default = true, false means don't write stderr
  	stdout: true // default = true, false means don't write stdout
  }

  clear()

  exec('sh bootstrap/bootstrap.sh', function (err, stdout, stderr) {
    console.log(stdout)
    console.log(stderr)
    cb(err)
  })

  return "sweetdude"
})

// gutil.log('Gulp is running!')


// Watch Files For Changes
gulp.task('watch', function() {

  // Run once at start.
  gulp.start('bootstrap')

	gulp.watch([
		'**/*',
		'!shell/**/*.fish',
		'!shell/**/*.zsh',
		'!**/*.md',
		'!**/*.txt'
	], ['bootstrap'])
    // gulp.watch('./**/*', gulp.parallel('concat', 'uglify'));
    // gulp.watch('js/*.js', ['lint', 'scripts']);
})

// Default Task
gulp.task('default', ['watch'])