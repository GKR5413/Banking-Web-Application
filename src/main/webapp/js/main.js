function setError(element, message) {
	const
		inp = element.parentElement;
	const
		err = inp.querySelector('.error');
	err.innerText = message;
}

function setSuccess(element) {
	const
		inp = element.parentElement;
	const
		err = inp.querySelector('.error');
	err.innerText = '';
}

$(document)
	.ready(
		function() {

			// Email validation

			$('#accounttype').on('input', function() {
				if ($('#accounttype').val() == '') {
					$('.select_error1').text('Required..!');
					$('.select_error1').fadeIn('fast');
					$('#accounttype').removeClass("user-input");
					$('#accounttype').addClass("err");
				} else {
					$('.select_error1').fadeOut('fast');
					$('#accounttype').removeClass("user-input");
					$('#accounttype').removeClass("err");
					$('#accounttype').addClass("succ");
				}
			});

			$('#currency').on('input', function() {
				if ($('#currency').val() == '') {
					$('.select_error2').text('Required..!');
					$('.select_error2').fadeIn('fast');
					$('#currency').removeClass("user-input");
					$('#currency').addClass("err");
				} else {
					$('.select_error2').fadeOut('fast');
					$('#currency').removeClass("user-input");
					$('#currency').removeClass("err");
					$('#currency').addClass("succ");
				}
			});

			$('#email').on('input', function() {
				var val = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;

				if ($('#email').val() != "") {

					const
						v = document.getElementById('email');
					const
						inp = v.parentElement;
					const
						err = inp.querySelector('.error');

					if (val.test($('#email').val())) {

						err.innerText = '';
						$('#email').removeClass(
							"user-input");
						$('#email').removeClass("err");
						$('#email').addClass("succ");

					} else {
						err.innerText = 'Invalid Email!';
						$('#email').removeClass(
							"user-input");
						$('#email').addClass("err");
					}
				} else {
					err.innerText = 'Required!';
					$('#email').removeClass(
						"user-input");
					$('#email').addClass("err");
				}
			});

			// mobile

			$('#phone').on('input', function() {

				var val2 = /^\(?(\d{3})\)?[- ]?(\d{3})[- ]?(\d{4})$/;

				if ($('#phone').val() != "") {

					const
						v = document.getElementById('phone');
					const
						inp = v.parentElement;
					const
						err = inp.querySelector('.error');

					if (val2.test($('#phone').val())) {

						err.innerText = '';
						$('#phone').removeClass("user-input");
						$('#phone').removeClass("err");
						$('#phone').addClass("succ");
					} else {
						err.innerText = 'Invalid Phone Number!';
						$('#phone').removeClass("user-input");
						$('#phone').addClass("err");
					}

				} else {
					err.innerText = 'Required!';
					$('#phone').removeClass("user-input");
					$('#phone').addClass("err");
				}
			});

			// f_name and l_name
			$('#name1').on('input', function() {
				var val3 = /^[a-zA-Z ]{2,15}$/;

				if ($('#name1').val() != "") {

					const
						v = document
							.getElementById('name1');
					const
						inp = v.parentElement;
					const
						err = inp.querySelector('.error');

					if (val3.test($('#name1').val())) {

						err.innerText = '';
						$('#name1').removeClass(
							"user-input");
						$('#name1').removeClass("err");
						$('#name1').addClass("succ");
					} else if ($('#name1').val().length < 2
						|| $('#name1').val().length > 15) {

						err.innerText = 'Note: Length should be between 2 and 15!';

						$('#name1').removeClass(
							"user-input");
						$('#name1').addClass("err");
					} else {
						err.innerText = 'no special characters allowed';

						$('#name1').removeClass(
							"user-input");
						$('#name1').addClass("err");
					}

				} else {
					err.innerText = 'Required!';

					$('#name1').removeClass(
						"user-input");
					$('#name1').addClass("err");
				}
			});

			$('#name2')
				.on(
					'input',
					function() {
						var val3 = /^[a-zA-Z ]{1,15}$/;

						if ($('#name2').val() != "") {

							const
								v = document
									.getElementById('name2');
							const
								inp = v.parentElement;
							const
								err = inp.querySelector('.error');

							if (val3.test($('#name2').val())) {

								err.innerText = '';
								$('#name2').removeClass(
									"user-input");
								$('#name2').removeClass("err");
								$('#name2').addClass("succ");
							} else if ($('#name2').val().length < 2
								|| $('#name2').val().length > 15) {

								err.innerText = 'Note: Length should be between 2 and 15!';

								$('#name2').removeClass(
									"user-input");
								$('#name2').addClass("err");
							} else {
								err.innerText = 'no special characters allowed';

								$('#name2').removeClass(
									"user-input");
								$('#name2').addClass("err");
							}

						} else {
							err.innerText = 'Required!';

							$('#name2').removeClass(
								"user-input");
							$('#name2').addClass("err");
						}
					});

			// password

			$('#pass')
				.on(
					'input',
					function() {
						var re = /^(?=.*\d)(?=.*[!@#$%^&*])(?=.*[a-z])(?=.*[A-Z]).{8,}$/;
						if ($('#pass').val() != "") {

							const
								v = document.getElementById('pass');
							const
								inp = v.parentElement;
							const
								err = inp.querySelector('.error');

							if (re.test($('#pass').val())) {
								err.innerText = '';
								$('#pass').removeClass("err");
								$('#pass').addClass("succ");
							} else if ($('#pass').val().length < 8) {
								err.innerText = 'Atleast 8 characters!';
								$('#pass').removeClass(
									"user-input");
								$('#pass').addClass("err");
							} else {
								err.innerText = 'Password must contain atleast one digit, one lowercase letter and one uppercase letter';
								$('#pass').removeClass(
									"user-input");
								$('#pass').addClass("err");
							}
						} else {
							err.innerText = 'Required!';
							$('#pass')
								.removeClass("user-input");
							$('#pass').addClass("err");
						}
					});

			// confirm pass

			$('#passc').on('input', function() {
				var cred1 = $('#pass').val();
				var cred2 = $('#passc').val();

				const
					v = document.getElementById('passc');
				const
					inp = v.parentElement;
				const
					err = inp.querySelector('.error');

				if ($('#passc').val() != "") {

					if (cred1 !== cred2) {
						err.innerText = "Password doesn't match!";
						$('#passc').removeClass("user-input");
						$('#passc').addClass("err");
					} else {
						err.innerText = '';
						$('#passc').removeClass("user-input");
						$('#passc').removeClass("err");
						$('#passc').addClass("succ");
					}
				} else {
					err.innerText = 'Required!';
					$('#passc').removeClass("user-input");
					$('#passc').addClass("err");
				}

			});

			// Savings account

			$('#address_row_1').on('input', function() {
				const
					v1 = document.getElementById('address_row_1');

				if (v1.value.trim() === '') {
					setError(v1, 'Required!...');
					$('#address_row_1').removeClass("user-input");
					$('#address_row_1').addClass("err");
				} else {
					setSuccess(v1);
					$('#address_row_1').removeClass("user-input");
					$('#address_row_1').removeClass("err");
					$('#address_row_1').addClass("succ");
				}
			});

			$('#address_row_2').on('input', function() {
				const
					v2 = document.getElementById('address_row_2');
				if (v2.value.trim() == '') {
					setError(v2, 'Required!...');
					$('#address_row_2').removeClass("user-input");
					$('#address_row_2').addClass("err");
				} else {
					setSuccess(v2);
					$('#address_row_2').removeClass("user-input");
					$('#address_row_2').removeClass("err");
					$('#address_row_2').addClass("succ");
				}
			});

			$('#address_row_3').on('input', function() {
				const
					v3 = document.getElementById('address_row_3');
				if (v3.value.trim() === '') {
					setError(v3, 'Required!...');
					$('#address_row_3').removeClass("user-input");
					$('#address_row_3').addClass("err");
				} else {
					setSuccess(v3);
					$('#address_row_3').removeClass("user-input");
					$('#address_row_3').removeClass("err");
					$('#address_row_3').addClass("succ");
				}
			});

			$('#address_row_4').on('input', function() {
				const
					v4 = document.getElementById('address_row_4');

				if (v4.value.trim() === '') {
					setError(v4, 'Required!...');
					$('#address_row_4').removeClass("user-input");
					$('#address_row_4').addClass("err");
				} else {
					setSuccess(v4);
					$('#address_row_4').removeClass("user-input");
					$('#address_row_4').removeClass("err");
					$('#address_row_4').addClass("succ");
				}
			});

			$('#address_row_5').on('input', function() {
				const
					v5 = document.getElementById('address_row_5');

				if (v5.value.trim() === '') {
					setError(v5, 'Required!...');
					$('#address_row_5').removeClass("user-input");
					$('#address_row_5').addClass("err");
				} else {
					setSuccess(v5);
					$('#address_row_5').removeClass("user-input");
					$('#address_row_5').removeClass("err");
					$('#address_row_5').addClass("succ");
				}
			});

			const
				proo = document.getElementById('id_prood_1');
			proo.on('input', function() {
				const
				re = /^[2-9]{1}[0-9]{3}\\s[0-9]{4}\\s[0-9]{4}$/;
				if ($('#id_proof_1').val() == '') {
					setError()
				}
			});

		});
