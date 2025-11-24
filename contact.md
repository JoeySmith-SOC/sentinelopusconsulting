---
layout: page
title: Contact
permalink: /contact/
---

<section class="contact-intro">
  <p>I work with security leads, engineering managers, and operations teams who need identity, Zero Trust, automation, or OT security delivered cleanly. Typical response time: within 1 business day.</p>
  <ul>
    <li>Projects I take: Okta/identity cleanups, Zero Trust rollouts, Linux/Ansible automation, OT segmentation and access.</li>
    <li>Projects I skip: checkbox-only compliance with no engineering follow-through.</li>
  </ul>
  <p class="contact-email">Prefer email? <a href="mailto:joeysmith@sentinelopusconsulting.com">joeysmith@sentinelopusconsulting.com</a></p>
  <a class="btn ghost" href="https://cal.com/" target="_blank" rel="noreferrer">Book a 30-minute intro call</a>
</section>

<section class="contact-form-wrap">
  <h2>Tell me about your project</h2>
  <p class="contact-helper">Include your tools, pain points, and timeline so I can respond with a clear next step.</p>
  <form id="contactForm" action="https://formspree.io/f/YOUR_FORM_ID" method="POST" class="contact-form" novalidate>
    <label for="name">Name
      <input type="text" id="name" name="name" placeholder="Your name" required>
    </label>
    <label for="email">Email
      <input type="email" id="email" name="_replyto" placeholder="you@example.com" required>
    </label>
    <label for="company">Company
      <input type="text" id="company" name="company" placeholder="Optional">
    </label>
    <label for="message">What are you trying to fix or ship?
      <textarea id="message" name="message" rows="6" placeholder="What are you trying to fix or ship?" required></textarea>
    </label>
    <button type="submit" class="btn primary">Send</button>
    <p class="form-status success" role="status" hidden>Thanks — got your note. I’ll reply within 1 business day.</p>
    <p class="form-status error" role="alert" hidden>Something went wrong. Please email me directly or try again.</p>
  </form>
</section>

<section class="contact-include">
  <h3>What to include</h3>
  <ul>
    <li>Current tools (Okta, Cloudflare, AD, SCADA/OT vendors)</li>
    <li>Where things hurt (access drift, outages, manual toil)</li>
    <li>Timeline or hard deadlines</li>
  </ul>
</section>

<script>
  const form = document.getElementById('contactForm');
  if (form) {
    const successMsg = form.querySelector('.form-status.success');
    const errorMsg = form.querySelector('.form-status.error');
    form.addEventListener('submit', async (e) => {
      e.preventDefault();
      successMsg.hidden = true;
      errorMsg.hidden = true;
      const data = new FormData(form);
      try {
        const res = await fetch(form.action, {
          method: 'POST',
          body: data,
          headers: { 'Accept': 'application/json' }
        });
        if (res.ok) {
          form.reset();
          successMsg.hidden = false;
        } else {
          errorMsg.hidden = false;
        }
      } catch (err) {
        errorMsg.hidden = false;
      }
    });
  }
</script>
