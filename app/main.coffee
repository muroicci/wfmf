
require('jQuery')
require('transit')

$ ->

	@MAX_REGISTER_NUM = 30

	$('li>span').hide()
	@counter = Math.floor( Math.random()*4 )
	@winW = $(window).width()
	@winH = $(window).height()

	@lastCalledNumbers = [1..5]

	window.speechSynthesis.getVoices()

	@callCustomer = =>
		@counter = (@counter+1)%4

		# show number
		loop
			num = Math.floor(Math.random()*@MAX_REGISTER_NUM)+1
			break if not (num in @lastCalledNumbers)

		elm = $('li>span').eq(@counter)
		elm.html(num)
		elmH = elm.height()
		elm.show()
		elm.transition({y:-elmH},0).transition({y:@winH/2-elmH/2}, 500)
		elm.transition({y:@winH+elmH, delay:1500}, 500, => elm.hide())

		# voice
		if window.speechSynthesis
			msg = new SpeechSynthesisUtterance("Register #{num}")
			voices = window.speechSynthesis.getVoices()
			for voice in voices 
				# console.log voice.name
				switch voice.name
					when "Alex"
						maleVoice = voice
					when "Vicki"
						femaleVoice = voice

			# console.log maleVoice
			msg.rate = 0.90;
			msg.pitch = 1.05;
			if Math.random()<0.2
				msg.voice = femaleVoice
			else
				msg.voice = maleVoice

			window.speechSynthesis.speak(msg)

		@lastCalledNumbers.shift()
		@lastCalledNumbers.push(num)

		setTimeout(	@callCustomer, 2000+Math.random()*15000)

	$(window).on 'resize', (evt)=>
		@winW = $(window).width()
		@winH = $(window).height()

	setTimeout @callCustomer, 2000

