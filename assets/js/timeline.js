document.addEventListener("DOMContentLoaded", () => {
  const timelineItems   = document.querySelectorAll(".timeline-item");
  const expertiseCards  = document.querySelectorAll(".expertise-card");
  const missionBlocks   = document.querySelectorAll(".mission-animate");
  const certBlocks      = document.querySelectorAll(".cert-animate");

  const observer = new IntersectionObserver(
    (entries) => {
      entries.forEach((entry) => {
        if (entry.isIntersecting) {
          entry.target.classList.add("visible");
        }
      });
    },
    {
      threshold: 0.25,
    }
  );

  [...timelineItems, ...expertiseCards, ...missionBlocks, ...certBlocks]
    .forEach((el) => observer.observe(el));
});
