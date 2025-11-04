---
layout: default
title: Contact
permalink: /contact/
description: Start a secure implementation, advisory sprint, or retainer — let’s talk.
---
<section class="container">
  <h1>Contact</h1>
  <p class="muted">Prefer email? <a href="mailto:joeysmith@sentinelopusconsulting.com">joeysmith@sentinelopusconsulting.com</a></p>

  <form class="contact-form" method="POST" action="https://api.formspree.io/f/YOUR_ID_HERE">
    <input type="hidden" name="_subject" value="New inquiry from sentinelopusconsulting.com">
    <div class="row">
      <label>Name <input type="text" name="name" required></label>
      <label>Email <input type="email" name="email" required></label>
    </div>
    <label>Company <input type="text" name="company"></label>
    <label>Message <textarea name="message" rows="6" required placeholder="Tell me what you’re trying to achieve…"></textarea></label>
    <input type="text" name="_gotcha" style="display:none">
    <button class="btn primary" type="submit">Send</button>
  </form>
</section>
