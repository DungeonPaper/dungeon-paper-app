import 'package:dungeon_paper/app/widgets/atoms/advanced_floating_action_button.dart';
import 'package:dungeon_paper/app/widgets/atoms/rich_text_field.dart';
import 'package:dungeon_paper/core/utils/email_address_validator.dart';
import 'package:dungeon_paper/core/utils/string_validator.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/send_feedback_controller.dart';

class SendFeedbackView extends GetView<SendFeedbackController> {
  const SendFeedbackView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr.feedback.title),
        centerTitle: true,
      ),
      floatingActionButton: Obx(
        () => AdvancedFloatingActionButton.extended(
          onPressed: !controller.sending.value ? controller.send : null,
          label: Text(tr.feedback.send),
          icon: controller.sending.value
              ? const SizedBox.square(
                  dimension: 24, child: CircularProgressIndicator.adaptive())
              : const Icon(Icons.send),
        ),
      ),
      body: Form(
        key: controller.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            if (controller.user.isGuest) ...[
              Obx(
                () => TextFormField(
                  controller: controller.email.value,
                  validator: (email) => email?.isEmpty ?? true
                      ? null
                      : EmailAddressValidator().validator(email),
                  decoration: InputDecoration(
                    labelText: tr.feedback.form.email.label,
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
            TextFormField(
              controller: controller.title.value,
              textCapitalization: TextCapitalization.sentences,
              validator:
                  StringValidator(minLength: 1, maxLength: 100).validator,
              decoration: InputDecoration(
                labelText: tr.feedback.form.title.label,
              ),
            ),
            const SizedBox(height: 16),
            RichTextField(
              controller: controller.body.value,
              minLines: 10,
              maxLines: 10,
              textCapitalization: TextCapitalization.sentences,
              validator:
                  StringValidator(minLength: 1, maxLength: 100).validator,
              decoration: InputDecoration(
                labelText: tr.feedback.form.body.label,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
