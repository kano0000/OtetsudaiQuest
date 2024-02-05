document.addEventListener('turbolinks:load', function () {
  const startBtn = document.getElementById('startBtn');
  const completeBtn = document.getElementById('completeBtn');
  const retryBtn = document.getElementById('retryBtn');
  const okBtn = document.getElementById('okBtn');
  const clearBtn = document.getElementById('clearBtn');
  const statusDisplay = document.getElementById('statusDisplay');

  let currentStatus = <%= @task.status %>;

  startBtn.addEventListener('click', function () {
    currentStatus = 1;
    updateStatus(currentStatus);
  });

  completeBtn.addEventListener('click', function () {
    currentStatus = 2;
    updateStatus(currentStatus);
  });

  retryBtn.addEventListener('click', function () {
    currentStatus = 3;
    updateStatus(currentStatus);
  });

  okBtn.addEventListener('click', function () {
    currentStatus = 4;
    updateStatus(currentStatus);
  });

  clearBtn.addEventListener('click', function () {
    window.location.href = 'https://example.com/another-page';
  });

  function updateStatus(status) {
    // Update status via Ajax
    fetch('/tasks/<%= @task.id %>/update_status?status=' + status, { method: 'PATCH' })
      .then(response => response.json())
      .then(data => {
        currentStatus = data.status;
        statusDisplay.textContent = 'Status: ' + getStatusText(currentStatus);
        updateUI();
      });
  }

  function updateUI() {
    startBtn.classList.add('hidden');
    completeBtn.classList.add('hidden');
    retryBtn.classList.add('hidden');
    okBtn.classList.add('hidden');
    clearBtn.classList.add('hidden');

    switch (currentStatus) {
      case 1:
        completeBtn.classList.remove('hidden');
        break;
      case 2:
        retryBtn.classList.remove('hidden');
        okBtn.classList.remove('hidden');
        break;
      case 3:
        startBtn.classList.remove('hidden');
        break;
      case 4:
        clearBtn.classList.remove('hidden');
        break;
      default:
        startBtn.classList.remove('hidden');
        break;
    }
  }

  function getStatusText(status) {
    switch (status) {
      case 1:
        return 'In Progress';
      case 2:
        return 'Reported Complete';
      case 3:
        return 'Retry';
      case 4:
        return 'Completed';
      default:
        return 'Preparing';
    }
  }
});
