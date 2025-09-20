<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Formulaire d'Avis Client - Moderne</title>
  <style>
    @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap');
    
    :root {
      --primary: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      --secondary: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
      --accent: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
      --success: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
      --warning: linear-gradient(135deg, #ffecd2 0%, #fcb69f 100%);
      --danger: linear-gradient(135deg, #ff9a9e 0%, #fecfef 100%);
      
      --bg-primary: #0f0f23;
      --bg-secondary: #1a1a2e;
      --bg-card: rgba(255, 255, 255, 0.05);
      --bg-glass: rgba(255, 255, 255, 0.1);
      
      --text-primary: #ffffff;
      --text-secondary: #b8b8ff;
      --text-muted: #8888aa;
      
      --border: rgba(255, 255, 255, 0.1);
      --shadow: 0 8px 32px rgba(31, 38, 135, 0.37);
      --shadow-hover: 0 15px 45px rgba(31, 38, 135, 0.5);
      
      --radius: 20px;
      --radius-sm: 12px;
    }

    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
      background: var(--bg-primary);
      color: var(--text-primary);
      min-height: 100vh;
      overflow-x: hidden;
      position: relative;
    }

    /* Animated background */
    body::before {
      content: '';
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background: 
        radial-gradient(circle at 20% 80%, rgba(120, 119, 198, 0.3) 0%, transparent 50%),
        radial-gradient(circle at 80% 20%, rgba(255, 119, 198, 0.3) 0%, transparent 50%),
        radial-gradient(circle at 40% 40%, rgba(120, 219, 255, 0.2) 0%, transparent 50%);
      z-index: -1;
    }

    /* Floating particles */
    .particles {
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      pointer-events: none;
      z-index: -1;
    }

    .particle {
      position: absolute;
      width: 4px;
      height: 4px;
      background: rgba(255, 255, 255, 0.3);
      border-radius: 50%;
      animation: float 6s ease-in-out infinite;
    }

    @keyframes float {
      0%, 100% { transform: translateY(0) rotate(0deg); opacity: 0.3; }
      50% { transform: translateY(-100px) rotate(180deg); opacity: 1; }
    }

    /* Navigation */
    .nav {
      position: fixed;
      top: 20px;
      left: 50%;
      transform: translateX(-50%);
      display: flex;
      background: var(--bg-glass);
      backdrop-filter: blur(20px);
      border: 1px solid var(--border);
      border-radius: 50px;
      padding: 8px;
      z-index: 1000;
    }

    .nav-item {
      padding: 12px 24px;
      background: transparent;
      margin-bottom: 12px;
      border: none;
      color: var(--text-secondary);
      border-radius: 50px;
      cursor: pointer;
      transition: all 0.3s ease;
      font-weight: 500;
      text-decoration: none;
      display: flex;
      align-items: center;
      gap: 8px;
    }

    .nav-item.active {
      background: var(--primary);
      color: white;
      transform: scale(1.05);
    }

    .nav-item:hover:not(.active) {
      background: rgba(255, 255, 255, 0.1);
      color: var(--text-primary);
    }

    /* Main container */
    .container {
      min-height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 100px 20px 40px;
    }

    /* Form styles */
    .form-container {
      width: 100%;
      max-width: 600px;
      position: relative;
      animation: slideUp 0.8s ease-out;
    }

    @keyframes slideUp {
      from { opacity: 0; transform: translateY(50px); }
      to { opacity: 1; transform: translateY(0); }
    }

    .form-card {
      background: var(--bg-glass);
      backdrop-filter: blur(20px);
      border: 1px solid var(--border);
      border-radius: var(--radius);
      padding: 40px;
      box-shadow: var(--shadow);
      position: relative;
      overflow: hidden;
    }

    .form-card::before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 2px;
      background: var(--primary);
    }

    .form-header {
      text-align: center;
      margin-bottom: 40px;
    }

    .form-icon {
      width: 80px;
      height: 80px;
      background: var(--primary);
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      margin: 0 auto 20px;
      position: relative;
      animation: pulse 2s ease-in-out infinite;
    }

    @keyframes pulse {
      0% { box-shadow: 0 0 0 0 rgba(102, 126, 234, 0.4); }
      70% { box-shadow: 0 0 0 20px rgba(102, 126, 234, 0); }
      100% { box-shadow: 0 0 0 0 rgba(102, 126, 234, 0); }
    }

    .form-icon i {
      font-size: 32px;
      color: white;
    }

    .form-title {
      font-size: 2rem;
      font-weight: 700;
      margin-bottom: 10px;
      background: linear-gradient(135deg, #fff, #b8b8ff);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
      background-clip: text;
    }

    .form-subtitle {
      color: var(--text-muted);
      font-weight: 400;
    }

    /* Form groups */
    .form-group {
      margin-bottom: 24px;
      position: relative;
    }

    .form-label {
      display: block;
      margin-bottom: 8px;
      font-weight: 600;
      color: var(--text-secondary);
      font-size: 14px;
      text-transform: uppercase;
      letter-spacing: 0.5px;
    }

    .form-input {
      width: 100%;
      padding: 16px 20px;
      background: rgba(255, 255, 255, 0.05);
      border: 1px solid var(--border);
      border-radius: var(--radius-sm);
      color: var(--text-primary);
      font-size: 16px;
      font-family: inherit;
      transition: all 0.3s ease;
      backdrop-filter: blur(10px);
    }

    .form-input:focus {
      outline: none;
      border-color: rgba(102, 126, 234, 0.5);
      background: rgba(255, 255, 255, 0.1);
      box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.1);
    }

    .form-input::placeholder {
      color: var(--text-muted);
    }

    /* Radio buttons */
    .radio-group {
      display: flex;
      gap: 20px;
      margin-top: 12px;
    }

    .radio-item {
      display: flex;
      align-items: center;
      gap: 8px;
      cursor: pointer;
      padding: 12px 20px;
      background: rgba(255, 255, 255, 0.05);
      border-radius: var(--radius-sm);
      border: 1px solid var(--border);
      transition: all 0.3s ease;
      flex: 1;
      justify-content: center;
    }

    .radio-item:hover {
      background: rgba(255, 255, 255, 0.1);
      border-color: rgba(102, 126, 234, 0.3);
    }

    .radio-item input[type="radio"] {
      display: none;
    }

    .radio-item input[type="radio"]:checked + .radio-custom {
      background: var(--success);
      transform: scale(1.1);
    }

    .radio-item input[type="radio"]:checked ~ .radio-label {
      color: var(--text-primary);
      font-weight: 600;
    }

    .radio-custom {
      width: 20px;
      height: 20px;
      border-radius: 50%;
      background: rgba(255, 255, 255, 0.2);
      transition: all 0.3s ease;
      position: relative;
    }

    .radio-label {
      color: var(--text-secondary);
      font-weight: 500;
      transition: all 0.3s ease;
    }

    /* Textarea */
    textarea.form-input {
      resize: vertical;
      min-height: 120px;
      font-family: inherit;
    }

    /* Submit button */
    .submit-btn {
      width: 100%;
      padding: 18px;
      background: var(--primary);
      color: white;
      border: none;
      border-radius: var(--radius-sm);
      font-size: 16px;
      font-weight: 600;
      cursor: pointer;
      transition: all 0.3s ease;
      position: relative;
      overflow: hidden;
      text-transform: uppercase;
      letter-spacing: 0.5px;
    }

    .submit-btn::before {
      content: '';
      position: absolute;
      top: 0;
      left: -100%;
      width: 100%;
      height: 100%;
      background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
      transition: left 0.5s ease;
    }

    .submit-btn:hover::before {
      left: 100%;
    }

    .submit-btn:hover {
      transform: translateY(-2px);
      box-shadow: var(--shadow-hover);
    }

    .submit-btn:active {
      transform: translateY(0);
    }

    /* Opinions display */
    .opinions-container {
      width: 100%;
      max-width: 1400px;
      margin: 0 auto;
      padding: 20px;
    }

    .opinions-header {
      text-align: center;
      margin-bottom: 40px;
    }

    .opinions-title {
      font-size: 3rem;
      font-weight: 800;
      background: linear-gradient(135deg, #667eea, #764ba2, #f093fb);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
      background-clip: text;
      margin-bottom: 10px;
    }

    .opinions-subtitle {
      color: var(--text-muted);
      font-size: 1.2rem;
    }

    .opinions-grid {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(400px, 1fr));
      gap: 30px;
      margin-top: 40px;
    }

    .opinion-card {
      background: var(--bg-glass);
      backdrop-filter: blur(20px);
      border: 1px solid var(--border);
      border-radius: var(--radius);
      padding: 30px;
      position: relative;
      transition: all 0.4s ease;
      overflow: hidden;
      animation: cardIn 0.6s ease-out forwards;
      opacity: 0;
      transform: translateY(30px);
    }

    .opinion-card:nth-child(odd) {
      animation-delay: 0.1s;
    }

    .opinion-card:nth-child(even) {
      animation-delay: 0.2s;
    }

    @keyframes cardIn {
      to {
        opacity: 1;
        transform: translateY(0);
      }
    }

    .opinion-card::before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 3px;
      background: var(--accent);
    }

    .opinion-card:hover {
      transform: translateY(-8px);
      box-shadow: var(--shadow-hover);
      border-color: rgba(102, 126, 234, 0.3);
    }

    .opinion-header {
      display: flex;
      align-items: center;
      gap: 15px;
      margin-bottom: 25px;
      padding-bottom: 20px;
      border-bottom: 1px solid var(--border);
    }

    .opinion-avatar {
      width: 50px;
      height: 50px;
      background: var(--primary);
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      color: white;
      font-weight: 600;
      font-size: 18px;
    }

    .opinion-info h3 {
      font-weight: 600;
      color: var(--text-primary);
      margin-bottom: 4px;
    }

    .opinion-info p {
      color: var(--text-muted);
      font-size: 14px;
    }

    .opinion-field {
      margin-bottom: 16px;
      display: flex;
      flex-direction: column;
      gap: 6px;
    }

    .opinion-field-label {
      font-size: 12px;
      text-transform: uppercase;
      letter-spacing: 0.5px;
      color: var(--text-muted);
      font-weight: 600;
    }

    .opinion-field-value {
      color: var(--text-primary);
      font-weight: 500;
      word-wrap: break-word;
    }

    .satisfaction-positive {
      color: #38ef7d !important;
      font-weight: 600;
    }

    .satisfaction-negative {
      color: #f5576c !important;
      font-weight: 600;
    }

    /* Toggle between form and opinions */
    .view-toggle {
      position: fixed;
      bottom: 30px;
      right: 30px;
      background: var(--primary);
      color: white;
      border: none;
      width: 60px;
      height: 60px;
      border-radius: 50%;
      font-size: 24px;
      cursor: pointer;
      box-shadow: var(--shadow);
      transition: all 0.3s ease;
      z-index: 1000;
    }

    .view-toggle:hover {
      transform: scale(1.1);
      box-shadow: var(--shadow-hover);
    }

    .view-section {
      display: none;
    }

    .view-section.active {
      display: block;
    }

    /* Responsive */
    @media (max-width: 768px) {
      .container {
        padding: 80px 15px 20px;
      }

      .form-card {
        padding: 30px 20px;
      }

      .form-title {
        font-size: 1.5rem;
      }

      .opinions-grid {
        grid-template-columns: 1fr;
        gap: 20px;
      }

      .radio-group {
        flex-direction: column;
      }

      .nav {
        position: relative;
        top: auto;
        left: auto;
        transform: none;
        margin: 20px auto;
      }
    }
  </style>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <div class="particles"></div>

    <nav class="nav">
    <!-- <button class="nav-item active" onclick="showView('form')">
      <i class="fas fa-edit"></i>
      Nouvel Avis
    </button> -->
    <button class="nav-item" onclick="showView('opinions')">
      <i class="fas fa-comments"></i>
      <a href="reviews" class="nav-item">Voir les Avis</a>
    </button>
  </nav>

    <div id="form-view" class="view-section active">
    <div class="container">
      <div class="form-container">
        <div class="form-card">
          <div class="form-header">
            <div class="form-icon">
              <i class="fas fa-star"></i>
            </div>
            <h1 class="form-title">Partagez votre exp rience</h1>
            <p class="form-subtitle">Votre avis nous aide   am liorer nos services</p>
          </div>

          <form action="reviews" method="post" id="review-form">
                        <input type="hidden" id="user_id" name="user_id" value="1">
            <input type="hidden" id="dateVisite" name="dateVisite">

            <div class="form-group">
              <label class="form-label">Niveau de satisfaction</label>
              <div class="radio-group">
                <label class="radio-item">
                  <input type="radio" name="satisfaction" value=1 required>
                  <div class="radio-custom"></div>
                  <span class="radio-label">Satisfait</span>
                </label>
                <label class="radio-item">
                  <input type="radio" name="satisfaction" value=0>
                  <div class="radio-custom"></div>
                  <span class="radio-label">Non satisfait</span>
                </label>
              </div>
            </div>

            <div class="form-group">
              <label class="form-label" for="raison">Raison principale</label>
              <input 
                type="text" 
                id="raison" 
                name="raison" 
                class="form-input" 
                placeholder="Qu'est-ce qui a motiv  votre avis ?"
              >
            </div>

            <div class="form-group">
              <label class="form-label" for="commentaire">Commentaire d taill </label>
              <textarea 
                id="commentaire" 
                name="commentaire" 
                class="form-input" 
                placeholder="Partagez votre exp rience en d tail..."
                rows="4"
              ></textarea>
            </div>

            <div class="form-group">
              <label class="form-label" for="service">Service concern </label>
              <input 
                type="text" 
                id="service" 
                name="service" 
                class="form-input" 
                placeholder="Ex: Vente, Support, Livraison..."
                required
              >
            </div>

            <button type="submit" class="submit-btn">
              <i class="fas fa-paper-plane" style="margin-right: 8px;"></i>
              Envoyer mon avis
            </button>
          </form>
        </div>
      </div>
    </div>
  </div>
  </div>

  <script>
    // Generate floating particles
    function createParticles() {
      const particles = document.querySelector('.particles');
      for (let i = 0; i < 50; i++) {
        const particle = document.createElement('div');
        particle.className = 'particle';
        particle.style.left = Math.random() * 100 + '%';
        particle.style.top = Math.random() * 100 + '%';
        particle.style.animationDelay = Math.random() * 6 + 's';
        particle.style.animationDuration = (Math.random() * 3 + 3) + 's';
        particles.appendChild(particle);
      }
    }

    // View switching
    function showView(view) {
      const formView = document.getElementById('form-view');
      const opinionsView = document.getElementById('opinions-view');
      const navItems = document.querySelectorAll('.nav-item');

      // Hide all views
      formView.classList.remove('active');
      opinionsView.classList.remove('active');

      // Remove active from nav items
      navItems.forEach(item => item.classList.remove('active'));

      // Show selected view
      if (view === 'form') {
        formView.classList.add('active');
        navItems[0].classList.add('active');
      } else {
        opinionsView.classList.add('active');
        navItems[1].classList.add('active');
      }
    }

    // Form enhancements
    document.addEventListener('DOMContentLoaded', function() {
      createParticles();

      // Set the current date for the hidden input field
      document.getElementById('dateVisite').value = new Date().toISOString().split('T')[0];


      // Add focus effects to inputs
      const inputs = document.querySelectorAll('.form-input');
      inputs.forEach(input => {
        input.addEventListener('focus', function() {
          this.parentElement.style.transform = 'translateY(-2px)';
        });

        input.addEventListener('blur', function() {
          this.parentElement.style.transform = 'translateY(0)';
        });
      });

      // Add submit animation
      const submitBtn = document.querySelector('.submit-btn');
      const form = document.querySelector('form');
      
      if (form) {
        form.addEventListener('submit', function(e) {
          submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Envoi en cours...';
          submitBtn.disabled = true;
        });
      }

      // Add staggered animation to opinion cards
      const observerOptions = {
        threshold: 0.1,
        rootMargin: '0px 0px -50px 0px'
      };

      const observer = new IntersectionObserver((entries) => {
        entries.forEach((entry, index) => {
          if (entry.isIntersecting) {
            setTimeout(() => {
              entry.target.style.animationPlayState = 'running';
            }, index * 100);
          }
        });
      }, observerOptions);

      document.querySelectorAll('.opinion-card').forEach(card => {
        observer.observe(card);
      });
    });

    // Add typing effect for form title
    function typeWriter(element, text, speed = 50) {
      let i = 0;
      element.innerHTML = '';
      function type() {
        if (i < text.length) {
          element.innerHTML += text.charAt(i);
          i++;
          setTimeout(type, speed);
        }
      }
      type();
    }

    // Smooth scroll for navigation
    document.querySelectorAll('.nav-item').forEach(item => {
      item.addEventListener('click', function() {
        this.style.transform = 'scale(0.95)';
        setTimeout(() => {
          this.style.transform = '';
        }, 150);
      });
    });
  </script>
</body>
</html>