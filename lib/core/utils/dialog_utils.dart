Future<void> awaitConfirmation(
        Future<bool> confirmation, void Function() callback) =>
    confirmation.then((res) {
      if (res) callback();
    });
