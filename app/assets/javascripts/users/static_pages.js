$(document).ready(function() {
  var sign_in = $('#last-sign-in').data('last-sign-in');
  var time = new Date(sign_in);
  var date = moment(time).format("dddd, MMMM Do YYYY, h:mm:ss a");
  $('#last-sign-in').text(date);
  
  var billing = $('#billing-date').data('billing-date');
  var bill_date = moment.unix(billing);
  var format_billing_date = bill_date.format("MMMM Do, YYYY");
  $('#billing-date').text(format_billing_date);
  
  var cancel = $('#canceled-at').data('canceled-at');
  var cancel_date = moment.unix(cancel);
  var format_cancel_date = cancel_date.format('MMM Do, YYYY');
  $('#canceled-at').text(format_cancel_date);
  
  var plan_ends = $('#plan-ends-at').data('plan-ends-at');
  var plan_ends_date = moment.unix(plan_ends);
  var format_plan_ends_date = plan_ends_date.format('MMM Do, YYYY');
  $('#plan-ends-at').text(format_plan_ends_date);
  
  var trial_end_unix = $('#trial-remains').data('trial-end-date');
  var start = moment();
  var trial_ends = moment.unix(trial_end_unix);
  var trial_ends_in = trial_ends.from(start, true);
  $('#trial-remains').text(trial_ends_in);

  var payment_user_email = $('#payment-user-email').data('payment-user-email');

var handler = StripeCheckout.configure({
    key: 'pk_test_6QkkD6iEONfxnnTNxVsrqVgP',
    email: payment_user_email,
    panelLabel: 'Add Card',
    token: function(token) {
      // Use the token to create the charge with a server-side script.
      // You can access the token ID with `token.id`
      token.id
    }
  });

$('#update-payment').on('click', function(e) {
    // Open Checkout with further options
    console.log('click');
    handler.open({
      name: 'Machine Cheat Sheet',
    });
    e.preventDefault();
  });

  // Close Checkout on page navigation
  $(window).on('popstate', function() {
    handler.close();
  });





});

