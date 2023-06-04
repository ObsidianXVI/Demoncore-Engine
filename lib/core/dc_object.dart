part of demoncore;

abstract class DCObject {
  final String id;
  final String label;

  DCObject(this.label) : id = ID.generate(label);
}
